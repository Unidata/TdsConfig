from glob import glob
from xml.sax import make_parser
from xml.sax.expatreader import SAXParseException

import pytest

# find all xml file
catalogs = glob("./**/*.xml", recursive=True)


def is_well_formed(file):
    well_formed = False
    try:
        parser = make_parser()
        parser.parse(file)
        well_formed = True
        print("{} is well formed".format(file))
    except SAXParseException as spe:
        print("{} is not well formed".format(file))
        ex = spe.getException()
        print(ex)

    return well_formed


@pytest.mark.parametrize("cat", catalogs)
def test_eval(cat):
    assert is_well_formed(cat)
