import React, {Component} from 'react'
import PropTypes from 'prop-types'
import ProfessorItem from './professor_item'

class ProfessorList extends Component{
  render(){
    return(
      <div className='professor-list'>
      {
        this.props.professors.map((professor)=>{
          return(<ProfessorItem key={professor.id} {...professor} />)
        })
      }
      </div>
    )
  }
}

ProfessorList.propTypes = {
  professors: PropTypes.array,
  meta:       PropTypes.object
}

export default ProfessorList
