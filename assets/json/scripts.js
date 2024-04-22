// import fs from 'fs'
const fs = require('fs')
const filePath = './assets/json/problems.json'

function updateTestSuiteObjects() {
  function readJsonFile(filePath) {
    const data = fs.readFileSync(filePath, 'utf8')
    const jsonData = JSON.parse(data)
    return jsonData
  }

  function writeJsonFile(filePath, data) {
    const jsonData = JSON.stringify(data, null, 0)
    fs.writeFileSync(filePath, jsonData, 'utf8')
  }

  let data = readJsonFile(filePath)
  data = data.data.map((question) => {
    question.testSuite = question.testSuite.map((t) => {
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
