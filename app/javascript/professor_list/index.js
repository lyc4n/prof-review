import React from 'react'
import ReactDOM from 'react-dom'
import ProfessorList from './professor_list'

document.addEventListener('turbolinks:load', () => {
  let elem = $('.professor-list-container')[0]

  if(elem){
    let {data, meta} = JSON.parse(elem.dataset.professors)

    ReactDOM.render(
      <ProfessorList professors={data} meta={meta} />, elem
    )
  }
})
