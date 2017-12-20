import React from 'react-native';

const DoreOpen = React.NativeModules.DoreOpen;

export default {
  open: () => {
    return DoreOpen.open();
  },
};
