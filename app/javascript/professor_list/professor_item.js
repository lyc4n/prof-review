import React, {Component} from 'react'
import PropTypes from 'prop-types'

class ProfessorItem extends Component{
  render(){
    return(
      <div className="professor-list-item">
        <span>{this.props.fullName}</span>
        <hr/>
      </div>
    )
  }
}

ProfessorItem.propTypes = {
  id: PropTypes.number,
  fullName: PropTypes.string
}

export default ProfessorItem
