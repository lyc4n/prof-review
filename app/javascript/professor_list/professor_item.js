import React, {Component} from 'react'
import PropTypes from 'prop-types'

class ProfessorItem extends Component{
  render(){
    return(
      <div className='professor-list-item'>
        <h4 className='professor-list-item__name'>{this.props.fullName}</h4>
      </div>
    )
  }
}

ProfessorItem.propTypes = {
  id: PropTypes.number,
  fullName: PropTypes.string
}

export default ProfessorItem
