#!/usr/bin/env python
from __future__ import print_function
from io import open

import os
import os.path

build_file = 'build.info'

def get_config_includes(path):
    'Get files and directories to be included'
    # If we're given a directory, add filename
    if os.path.isdir(path):
        configfile = os.path.join(path, build_file)
    else:
        configfile = path

    # Return all lines in the file, if it exists, plus this path
    ret = [path]
    if os.path.exists(configfile):
        with open(configfile, 'r') as f:
            ret.extend(os.path.join(path, l.strip()) for l in f)
    return ret

exclude = {build_file, 'fetch.sh', 'config.zip'}
def get_files(path):
    '''
    Get relative and full paths for the files to be included.

    If we're given a file, return the base filename as well as full
    (normalized) path.

    If given a directory, walk it and return the full path to the file
    as well as its path relative to the directory passed in.
    '''
    if os.path.isfile(path):
        yield os.path.split(path)[-1], os.path.normpath(path)
    else:
        for root, dirs, files in os.walk(path):
            for name in files:
                if name not in exclude:
                    fullpath = os.path.join(root, name)
                    yield os.path.relpath(fullpath, path), fullpath

def write_script(scriptpath, configpath):
    'Create script for downloading this config file'
    lines = ['#!/bin/sh']

    # Enclosing script in '{}' forces it to be read into memory, dealing
    # with the problem of the script being modified (via jar xf) while
    # running.
    lines.append('{')

    # Fix any windows path separators
    configfile = os.path.split(configpath)[-1]
    configpath = configpath.replace('\\', '/')
    lines.append(('\twget'
                  ' --no-check-certificate'
                  ' https://raw.githubusercontent.com/Unidata/TdsConfig/master/%s'
                  ' -O %s')
                  % (configpath, configfile))
    lines.append('\tjar xf %s' % os.path.split(configpath)[-1])
    lines.append('\texit')
    lines.append('}\n')
    script = '\n'.join(lines)

    # Using binary mode to prevent writing \r on windows
    if os.path.exists(scriptpath):
        with open(scriptpath, 'rb') as f:
            if f.read() == script:
                return

    with open(scriptpath, 'wb') as f:
        f.write(script)

if __name__ == '__main__':
    import argparse
    import subprocess
    import time
    import zipfile

    # Process directory on command line
    parser = argparse.ArgumentParser(
            description='Create THREDDS configuration sets.')
    parser.add_argument('dirs', type=str, nargs='*',
            help='Directories to create THREDDS configuration set')
    args = parser.parse_args()

    # Used to replace the [DATA_DIR] string in pqact and xml files
    DATA_DIR = "/data/ldm/pub"

    # If we're not given a directory, just look at all the dirs for a
    # config file.
    if not args.dirs:
        args.dirs = [d for d in os.listdir('.')
                if os.path.isdir(d) and os.path.exists(os.path.join(d, build_file))]

    for builddir in args.dirs:
        print('Processing {}: '.format(builddir), end='')

        # Assemble a map of the path in the zipfile to the corresponding
        # path on our filesystem. All filepaths are relative to the
        # containing directory so that files in included directories
        # can be overridden by those later in the list
        files = dict()
        for d in get_config_includes(builddir):
            for fname,fullpath in get_files(d):
                files[fname] = fullpath

        # Write wget script
        outpath = os.path.join(builddir, 'config.zip')
        script = 'fetch.sh'
        scriptpath = os.path.join(builddir, script)
        write_script(scriptpath, outpath)

        # Include the script in the zipfile
        files[script] = scriptpath

        # Write these into the zipfile
        with zipfile.ZipFile(outpath, 'w', zipfile.ZIP_DEFLATED) as outf:
            for f,fullpath in sorted(files.items()):
                # Read the content from the file. We need to write the data
                # as a string to the zipfile so we can control file time
                # and eliminate spurious zip changes
                with open(fullpath, 'rb') as sourceFile:
                    data = sourceFile.read()

                # look for files that could have the [DATA_DIR] macro and
                # replace it with the correct value
                if ('pqact' in f) or (f[-3:] == 'xml'):
                    data = data.replace('${DATA_DIR}', DATA_DIR)

                # Set the modification time based on the last time the file
                # was committed in git
                unix_time = subprocess.check_output(['git', 'log', '-1',
                    '--format=%ct', fullpath])
                if unix_time:
                    unix_time = int(unix_time)
                else: # File hasn't been added to git yet
                    unix_time = int(os.stat('build.py').st_mtime)
                mtime = time.localtime(unix_time)[:6]

                zinfo = zipfile.ZipInfo(f, mtime)
                zinfo.external_attr = 0o644 << 16
                zinfo.compress_type = outf.compression

                outf.writestr(zinfo, data)
        print('wrote {}'.format(outpath))
