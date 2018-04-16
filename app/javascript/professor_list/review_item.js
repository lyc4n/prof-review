import React, {Component} from 'react'
import PropTypes from 'prop-types'
import Rating from 'react-rating'
import Truncate from 'react-truncate'
import ReviewFormModal from './review_form_modal'

class ReviewItem extends Component{
  constructor(props){
    super(props)
    this.state = {showFullDescription: false, reviewFormModalIsOpen: false}
  }

  renderModalForm(){
    return(
      <ReviewFormModal {...this.props}
        reviewFormModalIsOpen={this.state.reviewFormModalIsOpen}
        handleHideModalForm={this.handleHideModalForm.bind(this)}
        handleUpdate={this.handleUpdate.bind(this)} />
    )
  }

  handleDelete(e){
    e.preventDefault()
    if(confirm('Are you sure you want to delete this review?')){
      $.ajax({
        url: `/reviews/${this.props.id}`,
        method: 'post',
        data: {_method: 'delete'},
        dataType: 'json',
        success: ((response) =>{
          this.props.locallyRemoveCurrentUserReview(this.props.id)
          this.props.locallyUpdateReviewsSummaries(response.reviewsSummary)
        }).bind(this),
        error: () =>{
          alert("An error occured")
        }
      })
    }
  }

  handleShowModalForm(e){
    e.preventDefault()
    this.setState({reviewFormModalIsOpen: true})
  }

  handleHideModalForm(){
    this.setState({reviewFormModalIsOpen: false})
  }

  handleUpdate(updatedReview, successCallback){
    $.ajax({
      url: `/reviews/${this.props.id}`,
      method: 'post',
      data: {_method: 'put', review: updatedReview},
      dataType: 'json',
      success: ((response) =>{
        this.props.locallyUpdateCurrentUserReview(response.review)
        this.props.locallyUpdateReviewsSummaries(response.reviewsSummary)
        successCallback()
      }).bind(this),
      error: () =>{
        alert("An error occured")
      }
    })
  }

  handleReadMore(e){
    e.preventDefault()
    this.setState({showFullDescription: true})
  }

  reviewerName(){
    if(this.props.byCurrentUser){
      return('You')
    }else{
      return(this.props.userFullName)
    }
  }

  reviewDate(){
    let date = new Date(this.props.createdAt)
    return(date.toDateString())
  }

  renderMenu(){
    return(
      <div className='review-item__dropdown-menu dropdown text-right'>
        <a className='dropdown-toggle' type='button' data-toggle='dropdown'>
          <i className='fas fa-chevron-down '/>
        </a>
        <ul className='dropdown-menu'>
          <li><a href='#' onClick={this.handleShowModalForm.bind(this)}>Change my review</a></li>
          <li><a href='#' onClick={this.handleDelete.bind(this)}>Delete this review</a></li>
        </ul>
      </div>
    )
  }

  reviewRating(){
    return(
      <div className='review-item__top-info'>
        {this.reviewerName()} rated &nbsp;
        <span className='badge progress-bar-info'>
          {this.props.rating}<i className='fas fa-star'></i>
        </span>
        <span> — {this.reviewDate()}</span>
        {this.renderMenu()}
      </div>
    )
  }

  reviewDescription(){
    if(!!this.props.description == false){
      return null
    }

    let ellipsis =  <span>...
      <a href='#' onClick={this.handleReadMore.bind(this)}>Read more</a>
    </span>

    if(this.state.showFullDescription){
      return(
        <blockquote className='small'>
          {this.props.description}
        </blockquote>
      )
    }else{
      return(
        <blockquote className='small'>
          <Truncate lines={3} ellipsis={ellipsis}>
            {this.props.description}
          </Truncate>
        </blockquote>
      )
    }

  }

  render(){
    return(
      <div className='review-item'>
        {this.reviewRating()}
        {this.reviewDescription()}
        {this.renderModalForm()}
      </div>
    )
  }
}

ReviewItem.propTypes = {
  id: PropTypes.number,
  professorId: PropTypes.number,
  subjectId: PropTypes.number,
  userId: PropTypes.number,
  rating: PropTypes.number,
  description: PropTypes.string,
  createdAt: PropTypes.string,
  byCurrentUser: PropTypes.bool,
  locallyRemoveCurrentUserReview: PropTypes.func,
  locallyUpdateCurrentUserReview: PropTypes.func,
  locallyUpdateReviewsSummaries: PropTypes.func
}

export default ReviewItem
