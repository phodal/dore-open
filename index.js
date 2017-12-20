import { NativeModules } from 'react-native';

const RCTDoreOpen = NativeModules.DoreOpen

let DoreOpen = {}

DoreOpen.open = (options) => {
  return RCTDoreOpen.open(options);
}

module.exports = DoreOpen;
