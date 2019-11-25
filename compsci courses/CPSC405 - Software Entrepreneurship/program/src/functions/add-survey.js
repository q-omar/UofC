const { MongoClient } = require('mongodb');
const { insiightDb, insiightUser, insiightPw } = process.env;

const DB_URL = `mongodb://${insiightUser}:${insiightPw}@ds151863.mlab.com:51863/${insiightDb}`;

function errorResponse(callback, err) {
  console.error('END: Error response.');
  console.error(err);

  callback(null, {
    statusCode: 500,
    body: JSON.stringify({ error: err })
  });
};

function successResponse(callback, res) {
  console.log('END: Success response.');

  callback(null, {
    statusCode: 200,
    body: JSON.stringify(res)
  });
};

/**
 * Generates a random 4 digit ID to identify what surveys students 
 * have completed and convert type to String
 * @returns - String
 */
function getNewSurveyId() {
  return Math.floor(1000 + Math.random() * 9000).toString();
};

exports.handler = function(event, context, callback) {
  console.log('START: Received request.');

  const payload = JSON.parse(event.body);

  const survey = {
    surveyID: getNewSurveyId(),
    ...payload,
  };

  MongoClient.connect(DB_URL, { useNewUrlParser: true }, function(err, connection) {

    if (err) return errorResponse(callback, err);

    console.log('Database successfully connected.');

    const db = connection.db(insiightDb);
    const surveys = db.collection('surveys');

    // Happy path
    surveys.insertOne(survey, function(err, result) {
      if (err) errorResponse(callback, err);
      
      console.log('Added the following survey to the database: ')
      console.log(result.ops[0]);
    
      connection.close();
      successResponse(callback, {'response': 'Successfully sent survey'});
    });
  });
}