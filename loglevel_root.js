loglevel_root = null;

if(Meteor.isServer){
  loglevel_root = global;
} else {
  loglevel_root = window;
}
