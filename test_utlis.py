from utlis import get_input


def test_get_input():
    msg = 'this is test'
    assert msg == get_input(msg)
