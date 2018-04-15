import React, {Component} from 'react'
import PropTypes from 'prop-types'
import ProfessorItem from './professor_item'
import Pagination from 'react-js-pagination'

class ProfessorsFetcher{
  constructor(){
    this.endpoint = window.location.origin+window.location.pathname
  }

  perform(fetchOptions, beforeSendCallback, successCallback){
    this.beforeSendCallback =  beforeSendCallback
    $.ajax({
      url:        this.endpoint,
      data:       fetchOptions,
      dataType:   'json',
      beforeSend: ((request) => {
        if(this.beforeSendCallback){this.beforeSendCallback()}
      }).bind(this),
      success: successCallback,
      error:   (response) => {
        alert("Woops, an error occured.")
      }
    })
  }
}

class ProfessorList extends Component{
  constructor(props){
    super(props)
    this.state = $.extend({}, props)
  }

  handlePageChange(pageNumber){
    let fetchOptions = {page: pageNumber}
    let fetcher = new ProfessorsFetcher
    fetcher.perform(fetchOptions, null, function(response){
      this.setState({professors: response.data, meta: response.meta})
    }.bind(this))
  }

  renderPagination(){
    if(this.state.meta.totalPages > 1){
      return(
        <Pagination
            prevPageText={'← Previous'}
            nextPageText={'Next →'}
            hideFirstLastPages
            activePage={this.state.meta.currentPage}
            itemsCountPerPage={this.state.meta.perPage}
            totalItemsCount={this.state.meta.totalEntries}
            onChange={this.handlePageChange.bind(this)}
        />
      )
    }else{
      return null
    }
  }
  render(){
    return(
      <div className='professor-list'>
       {
         this.state.professors.map((professor)=>{
           return(<ProfessorItem key={professor.id} {...professor} />)
         })
       }
       {this. renderPagination()}
      </div>
    )
  }
}

ProfessorList.propTypes = {
  professors: PropTypes.array,
  meta:       PropTypes.object
}

export default ProfessorList
