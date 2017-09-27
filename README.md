# Ubuntu baseimage Meteor Docker Build

Ubuntu [baseimage](https://github.com/phusion/baseimage-docker) for build and run [MeteorJS](https://www.meteor.com) applications inside [docker](https://www.docker.com/) container.

# Features

- Ubuntu image based on [`phusion/baseimage-docker`](https://github.com/phusion/baseimage-docker) (look why and read about image features)
- [Meteor](https://www.meteor.com) preinstaled
- On build will be instaled Meteor verson from you app and NodeJS and NPM will be linked from this Meteor version for compatibylity.
- Don't depend on NodeJS installation (Meteor release NodeJS and NPM version is used).
- Your aplication will be builded inside docker container. Build host (like CI) don't require Meteor install.
- You can add volume linked to `/var/log/meteor.log` for Meteor logging outside of container.
- You can add more services or deamons to run in container for example [`memcached`](https://github.com/phusion/baseimage-docker#adding-additional-daemons)


## Project state
> Currently in beta testing. Not recomended for production use.


## How to use

See `/example` folder how to build your application docker container. Simply copy files from `/example` folder into your Meteor project. Setup options in `Dockerfile` and `docker-build.sh` file and run `sh docker-build.sh` for build your app image.

## Road map (todo)

- [X] Add image versions depended on baseimage and Meteor versions
	- at now solved with Meteor release update on build from your APP Meteor vesion
- [ ] Run app under Meteor user for security reasons
- [ ] Meteor proper loging with date-time (to syslog?)
- [ ] Add build tests
- [ ] Release production ready version
- [ ] Add optional Nginx and MongoDB install with custom config (or run in docker-compose)
- [ ] Add examples to install Imagemagick, Graphicmagick, etc. to use with Meteor

All Contribustions, bug reports or features request are welcome!

## Credits

- [MeteorJS](https://www.meteor.com)
- Builded from [`phusion/baseimage-docker`](https://github.com/phusion/baseimage-docker) image
- Inspired by [`tozd/docker-meteor`](https://github.com/tozd/docker-meteor) repository.
- Contributors:
	- [Martin Bucko](https://github.com/MartinBucko)

***Thanks guys!***

## License

[MIT](https://github.com/Treecom/baseimage-meteor/blob/master/LICENSE)



