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

  locallyRemoveCurrentUserReview(reviewId){
    let currentUserReviews = this.state.currentUserReviews.concat()
    let index = currentUserReviews.findIndex((review) =>{
      return review.id == reviewId
    })

    if(index > -1){
      currentUserReviews.splice(index, 1)
      this.setState({currentUserReviews: currentUserReviews})
    }
  }

  locallyAddCurrentUserReview(newReview){
    this.setState({
      currentUserReviews: [...(this.state.currentUserReviews), newReview]
    })
  }

  locallyUpdateCurrentUserReview(updatedReview){
    let currentUserReviews = this.state.currentUserReviews.concat()

    let index = currentUserReviews.findIndex((review) =>{
      return review.id == updatedReview.id
    })

    if(index > -1){
      this.setState({
        currentUserReviews: [
           ...currentUserReviews.slice(0, index),
           updatedReview,
           ...currentUserReviews.slice(index + 1)]
      })
    }

  }

  locallyUpdateReviewsSummaries(updatedSummary){
    let reviewsSummaries = this.state.reviewsSummaries.concat()

    let index = reviewsSummaries.findIndex((summary) =>{
      return summary.professorId == updatedSummary.professorId &&
             summary.subjectId   == updatedSummary.subjectId
    })

    if(index > -1){
      this.setState({
        reviewsSummaries: [
           ...reviewsSummaries.slice(0, index),
           updatedSummary,
           ...reviewsSummaries.slice(index + 1)]
      })
    }else{
      this.setState({
        reviewsSummaries: [
           ...reviewsSummaries,
           updatedSummary]
      })
    }
  }

  handlePageChange(pageNumber){
    let fetchOptions = {page: pageNumber}
    let fetcher = new ProfessorsFetcher
    fetcher.perform(fetchOptions, null, function(response){
      this.setState({
        professors: response.data,
        currentUserReviews: response.currentUserReviews,
        reviewsSummaries: response.reviewsSummaries,
        meta: response.meta})
    }.bind(this))
  }

  renderPagination(){
    if(this.state.meta.totalPages > 1){
      return(
        <div className='pagination-container'>
          <Pagination
              prevPageText={'← Previous'}
              nextPageText={'Next →'}
              hideFirstLastPages
              activePage={this.state.meta.currentPage}
              itemsCountPerPage={this.state.meta.perPage}
              totalItemsCount={this.state.meta.totalEntries}
              onChange={this.handlePageChange.bind(this)}
          />
        </div>
      )
    }else{
      return null
    }
  }

  currentUserReviewFor(professorId){
    return(
      this.state.currentUserReviews.find((review)=>{
        return(review.professorId == professorId)
      }) || null
    )
  }

  reviewsSummaryFor(professorId){
    return(
      this.state.reviewsSummaries.find((summary)=>{
        return(summary.professorId == professorId)
      }) || null
    )
  }

  render(){
    let reviewItemFunctions = {
      locallyRemoveCurrentUserReview: this.locallyRemoveCurrentUserReview.bind(this),
      locallyAddCurrentUserReview: this.locallyAddCurrentUserReview.bind(this),
      locallyUpdateCurrentUserReview: this.locallyUpdateCurrentUserReview.bind(this),
      locallyUpdateReviewsSummaries: this.locallyUpdateReviewsSummaries.bind(this)}

    return(
      <div className='professor-list'>
       {
         this.state.professors.map((professor)=>{
           return(<ProfessorItem key={professor.id}
             subject={this.props.subject}
             currentUserReview={this.currentUserReviewFor(professor.id)}
             reviewsSummary={this.reviewsSummaryFor(professor.id)}
             {...professor} {...reviewItemFunctions} />
           )
         })
       }
       {this. renderPagination()}
      </div>
    )
  }
}

ProfessorList.propTypes = {
  professors: PropTypes.array,
  currentUserReviews: PropTypes.array,
  reviewsSummaries: PropTypes.array,
  meta:       PropTypes.object
}

export default ProfessorList
