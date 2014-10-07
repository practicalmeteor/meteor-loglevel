if(Meteor.isServer) {
  if(Meteor.settings && Meteor.settings.loglevel) {
    log.setLevel(Meteor.settings.loglevel);
  }
} else {
  if(Meteor.settings && Meteor.settings.public && Meteor.settings.public.loglevel) {
    log.setLevel(Meteor.settings.public.loglevel);
  }
}
