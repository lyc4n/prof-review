import React from 'react'
import ReactDOM from 'react-dom'
import ProfessorList from './professor_list'

document.addEventListener('turbolinks:load', () => {
  let elem = $('.professor-list-container')[0]

  if(elem){
    let {data, meta, reviewsSummaries, currentUserReviews, subject} = JSON.parse(elem.dataset.professors)

    ReactDOM.render(
      <ProfessorList professors={data}
                     reviewsSummaries={reviewsSummaries}
                     currentUserReviews={currentUserReviews}
                     subject={subject}
                     meta={meta}  />, elem
    )
  }
})
