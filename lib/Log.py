import logging

log_format = "%(levelname)s %(asctime)s - %(message)s"
logging.basicConfig(filename='../logs/test.log',
                    level=logging.DEBUG,
                    format=log_format,
                    filemode='w')

def logging_information(message, type):
    if type == 'INFO':
        logging.info(message)
    elif type == 'DEBUG':
        logging.debug(message)
    else:
        logging.error(message)