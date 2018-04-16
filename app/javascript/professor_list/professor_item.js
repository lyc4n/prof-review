import React, {Component} from 'react'
import PropTypes from 'prop-types'
import Rating from 'react-rating'
import ReviewItem from './review_item'
import ReviewFormModal from './review_form_modal'

class ProfessorItem extends Component{
  constructor(props){
    super(props)

    this.state = {reviewFormModalIsOpen: false}
  }

  formatRating(rating){
    return (rating).toFixed(1)
  }

  handleHideModalForm(){
    this.setState({reviewFormModalIsOpen: false})
  }

  handleShowModalForm(){
    this.setState({reviewFormModalIsOpen: true})
  }

  handleCreateReview(review, successCallback){
    let newReview = $.extend({}, review, {subject_id: this.props.subject.id, professor_id: this.props.id})
    $.ajax({
      url: `/reviews`,
      method: 'post',
      data: {review: newReview},
      dataType: 'json',
      success: ((response) =>{
        this.props.locallyAddCurrentUserReview(response.review)
        this.props.locallyUpdateReviewsSummaries(response.reviewsSummary)
        successCallback()
      }).bind(this),
      error: () =>{
        alert("An error occured")
      }
    })
  }

  renderModalForm(){
    return(
      <ReviewFormModal
        handleCreate={this.handleCreateReview.bind(this)}
        reviewFormModalIsOpen={this.state.reviewFormModalIsOpen}
        handleHideModalForm={this.handleHideModalForm.bind(this)}
      />
    )
  }

  renderCurrentUserReview(){
    if(this.props.currentUserReview){
      let reviewItemFunctions = {
        locallyRemoveCurrentUserReview: this.props.locallyRemoveCurrentUserReview,
        locallyUpdateCurrentUserReview: this.props.locallyUpdateCurrentUserReview,
        locallyUpdateReviewsSummaries: this.props.locallyUpdateReviewsSummaries}

        return(<ReviewItem byCurrentUser={true}
              {...this.props.currentUserReview}
              {...reviewItemFunctions} />)
    }else{
      return(null)
    }
  }

  renderActionButtons(){
    return(
      <div className='text-right'>
        <div className='btn-group'>
          <button className='btn btn-primary' onClick={this.handleShowModalForm.bind(this)} disabled={!!this.props.currentUserReview}>
            Write a review
          </button>
          <button className='btn btn-info'  disabled={!!!this.props.reviewsSummary}>See reviews</button>
        </div>
      </div>
    )
  }

  renderReviewsSummary(){
    if(this.props.reviewsSummary){
      let {averageRating, reviewsCount} = this.props.reviewsSummary
      return(
        <div>
          <div className='lead'>
            {this.formatRating(averageRating)}&nbsp;
            <Rating
              placeholderRating={averageRating}
              emptySymbol={<i className='far fa-star'></i>}
              fullSymbol={<i className='fas fa-star'></i>}
              placeholderSymbol={<i className='fas fa-star'></i>}
              readonly={true}
            />
            &nbsp;
            {reviewsCount} Reviews
          </div>
          {this.renderCurrentUserReview()}
        </div>
      )
    }else{
      return(<p>No Reviews</p>)
    }
  }

  render(){
    return(
      <div className='professor-list-item'>
        <h4 className='professor-list-item__name lead'>{this.props.fullName}</h4>
        {this.renderReviewsSummary()}
        {this.renderActionButtons()}
        {this.renderModalForm()}
      </div>
    )
  }
}

ProfessorItem.propTypes = {
  id: PropTypes.number,
  fullName: PropTypes.string,
  currentUserReview: PropTypes.object,
  reviewsSummary: PropTypes.object,
  locallyRemoveCurrentUserReview: PropTypes.func,
  locallyAddCurrentUserReview: PropTypes.func,
  locallyUpdateReviewsSummaries: PropTypes.func,
  locallyUpdateCurrentUserReview: PropTypes.func
}

export default ProfessorItem
