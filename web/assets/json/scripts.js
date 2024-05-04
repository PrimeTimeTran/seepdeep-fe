// import fs from 'fs'
const fs = require('fs')

const filePath = './assets/json/problems.json'

function readJsonFile(filePath) {
  const data = fs.readFileSync(filePath, 'utf8')
  const jsonData = JSON.parse(data)
  return jsonData
}

function writeJsonFile(filePath, data) {
  const jsonData = JSON.stringify(data, null, 0)
  fs.writeFileSync(filePath, jsonData, 'utf8')
}

function getParameterType(value) {
  if (typeof value === 'string') return 'string'
  if (typeof value === 'number')
    return Number.isInteger(value) ? 'int' : 'double'
  if (typeof value === 'boolean') return 'bool' // Check for boolean type
  if (Array.isArray(value)) return 'list'
  return 'unknown'
}

function updateTestSuiteObjects() {
  let data = readJsonFile(filePath)
  data = data.data.map((question) => {
    question.testCases = question.testCases.map((t) => {
      const inputs = t.input.map((i) => {
        return {
          name: '',
          value: i,
        }
      })
      return { output: t.output, inputs, explanation: '' }
    })
    return question
  })
  writeJsonFile(filePath, data)
}

function addId() {
  let data = readJsonFile(filePath)
  data = data.data.map((question, idx) => {
    question.id = idx + 1
    return question
  })
  writeJsonFile(filePath, data)
}

function addSignature() {
  let data = readJsonFile(filePath)
  data = data.data.map((question, idx) => {
    if (question.testCases && question.testCases[0].inputs) {
      const parameters = Object.entries(question.testCases[0].inputs).map(
        ([key, value], idx) => ({
          type: getParameterType(value.value),
          name: question.signature.parameters[idx].name,
        })
      )
      question.signature = {
        parameters,
        returnType: getParameterType(question.testCases[0].output),
      }
    }
    return question
  })
  writeJsonFile(filePath, { data })
}

// addSignature()

function changeInputType() {
  let data = readJsonFile(filePath)
  data = data.data.map((question) => {
    if (question.testCases) {
      question.testCases.forEach((testCase, idx) => {
        const inputs = testCase.inputs.map((input) => input.value)
        delete question.testCases[idx].inputs
      })
    }
    return question
  })
  writeJsonFile(filePath, { data });
}
changeInputType()
