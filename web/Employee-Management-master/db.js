const {MongoClient}=require('mongodb')
const url='mongodb://localhost:27017'

const connectdb = (dbname) => {
    return MongoClient.connect(url)
        .then(async client  => {
            // await client.db(dbname).collection('users').createIndex([{name: 'username_email_text', key:{username:'text',email:'text'}}], function(err, result) {
            //     console.log(err);
            //     console.log(result);

            //   });
            return client.db(dbname)
        })
}

module.exports = connectdb