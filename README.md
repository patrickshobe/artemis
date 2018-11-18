# artemis

artemis is my attempt at implementing a distributed media transcoding application.

## Main Details

I use [Plex Media Server](www.plex.tv), to host of all of my personal media,
the majority of the media is being consumned by low end streaming devices that
do not support more modern video formats. This causes the server to have to
transcode the video into an older format on the fly and quickly becomes problematic
as you add more concurrent streams. To avoid this I generally try and
encode media into the more universally playable .mp4 (AAC, h264) format.
This is genereally an arduous process of creating queus and kicking off
jobs during non peak hours, it's nearly impossible to keep up with the
incoming amount of media. Artemis aims to solve this problem by interfacing
with the main media retrieval services [sonarr](www.sonarr.tv) and
[radarr](www.radarr.video) and having a controller - worker remote encoding server
implementation utilizing other computers on the local network.

![](https://i.imgur.com/fdXQPl5.png)

### Current Implementation
Artemis and Apollo are currently working together. Aretmis can queue and dispatch encode
jobs to multiple apollo workers. 
