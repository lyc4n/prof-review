import React, {Component} from 'react'
import PropTypes from 'prop-types'
import Modal from 'react-bootstrap/lib/Modal'
import Button from 'react-bootstrap/lib/Button'
import Rating from 'react-rating'
import {RatingLabels} from '../app_constants'

class ReviewFormModal extends Component{
  constructor(props){
    super(props)

    this.state = {
      id: props.id,
      professorId: props.professorId,
      subjectId: props.subjectId,
      rating: props.rating,
      description: props.description
    }
  }

  updateRating(newRating){
    this.setState({rating: newRating} )
  }

  updateDescription(e){
    this.setState({description: e.target.value} )
  }

  handleUpdate(e){
    e.preventDefault()
    let updatedReview = {rating: this.state.rating, description: this.state.description}
    this.props.handleUpdate(updatedReview, (() =>{
      this.props.handleHideModalForm()
    }).bind(this))
  }

  handleCreate(e){
    let newReview = {rating: this.state.rating, description: this.state.description}
    this.props.handleCreate(newReview, (() =>{
      this.props.handleHideModalForm()
    }).bind(this))
  }

  renderSaveButton(){
    if(this.props.id){
      return(
        <Button bsStyle='primary' onClick={this.handleUpdate.bind(this)}>
          Save changes
        </Button>
      )
    }else{
      return(
        <Button
          bsStyle='primary'
          disabled={!!!this.state.rating}
          onClick={this.handleCreate.bind(this)}>Save
        </Button>)
    }
  }

  renderModalTitle(){
    let title = this.props.id ? 'Review Update' : 'Review'
    return <Modal.Title>{title}</Modal.Title>
  }

  render(){
    return(
      <div className='static-modal'>
        <Modal
          dialogClassName='review-form-modal'
          show={this.props.reviewFormModalIsOpen}
          onHide={this.props.handleHideModalForm}>
          <Modal.Header closeButton>
            {this.renderModalTitle()}
          </Modal.Header>

          <Modal.Body>
            <div className='text-center'>
              <Rating
                onChange={this.updateRating.bind(this)}
                initialRating={this.state.rating}
                emptySymbol={<i className='far fa-star fa-2x'></i>}
                fullSymbol={<i className='fas fa-star fa-2x'></i>}
                onHover={(hoverValue)=>{
                  this.ratingLabel.innerText = RatingLabels[hoverValue || this.state.rating] || 'Add your rating'
                }}
              />
              <div>
                <label className='rating-label text-primary' ref={(elem)=> this.ratingLabel = elem }>{RatingLabels[this.state.rating]}</label>
              </div>
            </div>

            <div>
              <textarea
                placeholder="Describe your experience when joining this professor's class. Did you learn a lot? Is there any thing you think could be improved to make a better educational experience?"
                className='form-control'
                onChange={this.updateDescription.bind(this)}
                defaultValue={this.state.description}>
              </textarea>
            </div>
          </Modal.Body>

          <Modal.Footer>
            <Button onClick={this.props.handleHideModalForm}>Close</Button>
            {this.renderSaveButton()}
          </Modal.Footer>
        </Modal>
      </div>
    )
  }
}

ReviewFormModal.propTypes = {
  id: PropTypes.number,
  professorId: PropTypes.number,
  subjectId: PropTypes.number,
  userId: PropTypes.number,
  rating: PropTypes.number,
  description: PropTypes.string,
  createdAt: PropTypes.string,
  handleHideModalForm: PropTypes.func,
  reviewFormModalIsOpen: PropTypes.bool,
  handleUpdate: PropTypes.func,
}

export default ReviewFormModal
