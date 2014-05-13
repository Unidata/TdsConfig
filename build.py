#!/usr/bin/env python
import os
import os.path

build_file = 'build.info'

def get_config_includes(path):
    'Get files and directories to be included'
    # If we're given a directory, add filename
    if os.path.isdir(path):
        configfile = os.path.join(path, build_file)

    # Return all lines in the file plus this path
    with open(configfile, 'r') as f:
        return [os.path.join(path, l.strip()) for l in f] + [path] 

exclude = {'build.info', 'fetch.sh', 'config.zip'}
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
    with open(scriptpath, 'w') as f:
        f.write('#!/bin/sh\n')
        f.write('wget https://raw.githubusercontent.com/Unidata/TdsConfig/master/%s\n' % configpath)
        f.write('jar xf %s\n' % os.path.split(configpath)[-1])

if __name__ == '__main__':
    import argparse
    import zipfile

    # Process directory on command line
    parser = argparse.ArgumentParser(
            description='Create THREDDS configuration sets.')
    parser.add_argument('dirs', type=str, nargs='?',
            help='Directories to create THREDDS configuration set')
    args = parser.parse_args()

    # If we're not given a directory, just look at all the dirs for a
    # config file.
    if not args.dirs:
        args.dirs = [d for d in os.listdir()
                if os.path.isdir(d) and os.path.exists(os.path.join(d, build_file))]

    for builddir in args.dirs:
        # Assemble a map of the path in the zipfile to the corresponding
        # path on our filesystem. All filepaths are relative to the
        # containing directory so that files in included directories
        # can be overridden by those later in the list
        files = dict()
        for d in get_config_includes(builddir):
            for fname,fullpath in get_files(d):
                files[fname] = fullpath

        # Write these into the zipfile
        outpath = os.path.join(builddir, 'config.zip')
        with zipfile.ZipFile(outpath, 'w', zipfile.ZIP_DEFLATED) as outf:
            for f,fullpath in files.items():
                outf.write(fullpath, f)

        # Write wget script
        write_script(os.path.join(builddir, 'fetch.sh'), outpath)
