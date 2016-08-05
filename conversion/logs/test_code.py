from autologging import logged, traced


@logged
@traced
class MyClass:
    def my_method(self, arg, keyword=None):
        if keyword is not None:
            self.__log.debug("taking the keyword branch")
            return "{} and {}".format(arg, keyword)
        return arg.upper()
