import logging.config

import autologging

from conversion.logs.test_code import MyClass

logging.config.dictConfig({
    "version": 1,
    "formatters": {
        "logformatter": {
            "format":
                "%(asctime)s:%(levelname)s:%(name)s:%(funcName)s:%(message)s",
        },
        "traceformatter": {
            "format":
                "%(asctime)s:%(process)s:%(levelname)s:%(filename)s:"
                "%(lineno)s:%(name)s:%(funcName)s:%(message)s",
        },
    },
    "handlers": {
        "loghandler": {
            "class": "logging.FileHandler",
            "level": logging.DEBUG,
            "formatter": "logformatter",
            "filename": "app.log",
        },
        "tracehandler": {
            "class": "logging.FileHandler",
            "level": autologging.TRACE,
            "formatter": "traceformatter",
            "filename": "trace.log",
        },
    },
    "loggers": {
        "lita": {
            "level": logging.INFO,
            "handlers": ["tracehandler", "loghandler"],
        },
    },
})

if __name__ == "__main__":
    obj = MyClass()
    obj.my_method("test")
    obj.my_method("spam", keyword="eggs")
