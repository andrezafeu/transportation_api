# Transportation API

#### Dependencies
- Ruby 2.3.0
- Rails 5.0.1

#### Getting Started
1. Install RVM
2. Install Ruby
3. Install Rails
4. Install [Docker Community Edition](https://www.docker.com/get-docker)
5. Clone repo
6. Run `docker-compose up`

#### Endpoints
- `api/trackers.json` - array of checkins from hardware trackers
- `api/trackers/:id.json` - array of checkins from a vehicle's tracker

#### Todo
- [ ] Reload rails api when code changes during development?
