#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import unicode_literals
import pyotherside
import youtube_dl

downloaddir = '/tmp'

class MyLogger(object):
    def debug(self, msg):
        pyotherside.send('log', 'debug: ' + msg)

    def warning(self, msg):
        pyotherside.send('log', 'warn: ' + msg)

    def error(self, msg):
        pyotherside.send('log', 'err: ' + msg)

logger = MyLogger()

ytdl_info_opts = {
    'dump_single_json': 'true',
    'simulate': 'true',
    'logger': logger
}

ytdl_info = youtube_dl.YoutubeDL(ytdl_info_opts);

def setDownloadDir(dir):
    downloaddir = dir

def retrieveVideoInfo(url):
    logger.debug('retrieveVideoUrl ' + str(url))
    info = ytdl_info.extract_info(url, download=False)
    return info

def downloadVideo(url):
    logger.debug('downloadVideo ' + str(url))
    # not implemented yet
