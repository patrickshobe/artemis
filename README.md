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

![diagram](https://i.imgur.com/qrvY6Lw.png)

### Current Implementation
Artemis and Apollo are currently working together. Aretmis can queue and dispatch encode
jobs to multiple apollo workers. 

## Running Locally

To run this locally there will be a lot of set up and possible code changes you will need to make, at this point the project is built in a way to specifically work on my machines on my VPN. 

### Dependencies

[apollo](https://github.com/patrickshobe/apollo) - Worker App
[sonarr](www.sonarr.tv) - TV File Manager
[persephone](https://github.com/patrickshobe/persephone) - Dashboard for Artemis

### Networking
**Ports**
For  every Controller, Worker, External Service you will need to open the respective port on your local network. **This does NOT need to be done to the external network! Be careful with what you are exposing to the external internet**
**VPN**
I recommend using a VPN to make this accessible outside of your local network safely, I utilized [hamachi](https://vpn.net)

**Storage**
The Media storage will need to be network attached and accessible from all servers, I used `smb` for this. 

**Artemis**
Each `worker` needs to have the location set i.e. `http://192.168.0.5:3100`
You need to set the path and API key for sonarr as an ENV variable `ENV['SONARR_ROUTE']` & `ENV['SONARR_API_KEY']`

**Apollo**
Needs to set an environment variable `ENV['ARTEMIS_PATH']` to the internal IP of your artemis servere, i.e. `192.168.0.4:3200`, I used [figaro](https://github.com/laserlemon/figaro) to manage ENV variables. 

### Kicking Things Off
There is currently no GUI functionality to kick off the workers, this has to be done from the rails console but once done the workers will run until there are no encodes left.  

To start an encode in the console do: `EncodeDispatch.dispatch (encoder_id)`

### Endpoints

All endpoints are prepended by your artemis local ip and port i.e. `192.168.0.5:3200` then  `/api/v1`

#### Encode Numbers
Returns the distribution of encodes by status, accepts a get with no header of body

```
GET '192.168.0.5:3200/api/v1/encode_numbers'

{ pending: 3000,
  completed: 250,
  percentage: 10% }
```

### Encodes By Day
Returns the number of encodes completed by day, accepts a get with no header or body. 
```
GET '192.168.0.5:3200/api/v1/encodes_by_day'

{ 2018-01-01: 10,
  2018-01-02: 12,
  2018-01-03: 6 }
```

### Pending Encodes
Returns the currently running encodes, accepts a get with no header or body. 
```
GET '192.168.0.5:3200/api/v1/pending_encodes'

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
GET '192.168.0.5:3200/api/v1/encode_records'

[{ worker: apollo-1,
  title: episode-title,
  series: series-name,
  season: 1,
  episode: 2,
  age: 20.47 }]
```
