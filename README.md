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

## Endpoints

All endpoints are prepended by `/api/v1`

#### Encode Numbers
Returns the distribution of encodes by status, accepts a get with no header of body
```
{ pending: 3000,
  completed: 250,
  percentage: 10% }
```

### Encodes By Day
Returns the number of encodes completed by day, accepts a get with no header or body. 
```
{ 2018-01-01: 10,
  2018-01-02: 12,
  2018-01-03: 6 }
```

### Pending Encodes
Returns the currently running encodes, accepts a get with no header or body. 
```
{ worker: apollo-1,
  title: episode-title,
  series: series-name,
  season: 1,
  episode: 2,
  age: 20.47 }
```
### Recent Encodes 
Returns the last 10 encode record, accepts a get with no header or body. 
```
[{ worker: apollo-1,
  title: episode-title,
  series: series-name,
  season: 1,
  episode: 2,
  age: 20.47 }]
```
