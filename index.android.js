import React from 'react-native';

const DoreOpen = React.NativeModules.DoreOpen;

export default {
  open: (onSuccess, onFailure) => {
    return DoreOpen.open(onSuccess, onFailure);
  },
};
