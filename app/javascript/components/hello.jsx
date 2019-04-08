import React, {Component} from 'react';

class Hello extends React.Component {
  constructor(props){
    super(props);
  }

  render() {
    return this.props.children
  }
};

export default Hello;
