import Ember from 'ember';

const {isBlank, A: a} = Ember;

function group (string, k, output=a()) {
  if (isBlank(string)) {
    return output;
  }

  if (k < 0) {
    output.unshiftObject(string.slice(k));
    return group(string.slice(0, k), k, output);
  } else {
    output.pushObject( string.slice(0, k) );
    return group(string.slice(k), k, output);
  }
}

export default group;