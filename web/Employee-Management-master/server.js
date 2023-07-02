const express=require('express')
const session=require('express-session')
const passport=require('./stratergy')
const connectdb=require('./db');
const async = require('hbs/lib/async');
const ObjectID = require('mongodb').ObjectID;

const fs = require('fs');

const svr = express()


svr.use('/', express.static(__dirname + '/public'))
svr.use('/', express.static(__dirname + '/public/new_ticket'))




svr.set('view engine', 'hbs')
svr.use(express.json())
svr.use(express.urlencoded({extended: true}))
svr.use(session({
    secret: 'kamehameha',
    resave: false,
    saveUninitialized: true
}))

svr.use(passport.initialize())
svr.use(passport.session())

function checklogin(req, res, next){
    if(req.user){
        return next()
    }
    res.redirect('/')
}

svr.get('/logout', checklogin, function(req, res){
    req.logout();
    res.redirect('/');
});

svr.get('/add_ticket', checklogin, (req, res) => {
    res.render('add_ticket')
})

svr.get('/about', checklogin, (req, res) => {
    let name=req.user.username
    res.render('about', {name})
})

svr.get('/contact', checklogin, (req, res) => {
    let name=req.user.username
    res.render('contact', {name})
})


    

svr.get('/new', (req, res) => {
    // let user=req.user.username
    res.render('new');
})

svr.post('/new', (req, res) => {
    let ia
    if(req.body.admin == 'Admin')
        ia=true
    else
        ia=false
    connectdb('empmanag')
    .then(db => db.collection('users').insertOne({
        username: req.body.username,
        email: req.body.email,
        password: req.body.password,
        dept: req.body.dept,
        desig: req.body.desig,
        isAdmin: ia
    }))
    .then(() => res.redirect('/new'))
})

svr.post('/add-ticket', (req, res) => {

    connectdb('empmanag')
    .then(db => db.collection('ticket').insertOne({
        airline_name: req.body.airline,
        from: req.body.from,
        to: req.body.to,
        departure: req.body.departure,
        arrival: req.body.arrival,
        price: req.body.price,
        total_seats: req.body.seats
    }))
    .then(() => res.redirect('/add_ticket')).catch(err => {
        console.error(err);
        // res.render('not_ound_tiket', {ticketData})
        res.status(500).json({ error: 'An error occurred' });
      }); 
    
})

svr.post('/search', (req, res) => {
    console.log(req.body);
    connectdb('empmanag')
  .then(db => db.collection('ticket').find({
    from: req.body.Origin,
    to: req.body.Destination,
  }))
  .then(cursor => cursor.toArray())
  .then(ticketData => {
    if (ticketData.length > 0) {
        console.log(ticketData);
        res.render('search', {ticketData})
      }else{
        res.render('not_ound_tiket')
        // not_ound_tiket.hbs
      }
  })
  .catch(err => {
    console.error(err);
    res.status(500).json({ error: 'An error occurred' });
  }); 
});

svr.post('/buy', (req, res) => {
    console.log(req.body.ticket_id);
    let id= new ObjectID(req.body.ticket_id)
    var ticketData  = req.user.tiket;
    connectdb('empmanag')
        .then(db => db.collection('ticket').find({ _id: id}))
        .then(det => det.toArray())
        .then(det => {//req.user._id
        ticketData.push(det[0]);
        const filter = { username: req.user.username }; // Specify the filter to find the user you want to update
        const update = { $set: { tiket:  ticketData} }; // Specify the update operation

        connectdb('empmanag')
        .then(db => db.collection('users').updateOne(filter, update, function(err, result) {
            // console.log(result);
        
        console.log("ticketData",ticketData)
        if (err) {
            var massage  = "The ticket has not been added";
            res.render('ticket', {ticketData, massage});
        }else{
            var massage  = "The ticket has been added";
            res.render('ticket', {ticketData, massage});
        }
    
    })
 
 )});
    
});


svr.get('/', (req, res) => {
    console.log("Redirect1")
    res.sendFile(__dirname + '/public/login.html')
})

svr.post('/login', passport.authenticate('local', {
    // successRedirect: '/home',
    failureRedirect: '/home'
}), function(req, res) {
    console.log("Redirect")
    console.log(req.user.dept)
    // Check if the logged-in user is an admin
    if (req.user.dept === 'Client') {
        // Redirect to the admin page
        console.log("Redirect to the regular user page")
        // Redirect to the regular user page
        res.redirect('client/index.html');
    } else {
        console.log("Redirect to the admin page")
        res.redirect('/home');
    }
});

svr.get('/home', checklogin, (req, res) => {
    console.log("Redirect")
    let user=req.user.username
    let type=req.user.isAdmin
    res.render('home', {type, user})
})

svr.get('/adddetails', checklogin, (req, res) => {
    let id=req.user._id
    let email=req.user.email
    let name=req.user.username
    first=name.split(' ')[0]
    last=name.split(' ')[1]
    res.render('adddetails', { email, first, last, id })
})

svr.post('/newuser', checklogin, (req, res) => {
    connectdb('empmanag')
        .then(db => db.collection('empdetails').insertOne({
            authId: req.body.id,
            name: req.body.fname + ' ' + req.body.lname,
            email: req.body.email,
            dob: req.body.dob,
            address: req.body.address,
            phone: req.body.phone,
            dept: req.user.dept,
            desig: req.user.desig,
        }))
        .then(() => res.redirect('/home'))
})

svr.get('/profile', checklogin, (req, res) => {
    let name=req.user.username
    let id=req.user._id
    connectdb('empmanag')
        .then(db => db.collection('empdetails').find({ authId: req.user._id }))
        .then(det => det.toArray())
        .then(det => {
            let len=det.length
            res.render('profile', {name, len, id})
        })
})

svr.get('/employees', checklogin, (req, res) => {
    let user=req.user.username
        
    // connectdb('empmanag').then(db => db.collection('ticket').find().toArray(function(err, docs) {
    //     if (err) throw err;
    //     console.log('Listttttt ticket');
    //     console.log(docs); // an array of all the documents in the collection
    //   }));
    connectdb('empmanag')
        .then(db => db.collection('users').find({isAdmin: false}).sort({projno: -1}).limit(10))
        .then(emps => emps.toArray())
        .then(emps => {
            res.render('employees', {emps, user})
        })
})

svr.get('/getdetails/:id', checklogin, (req, res) => {
    connectdb('empmanag')
        .then(db => db.collection('empdetails').find({authId: req.params.id}))
        .then(det => det.toArray())
        .then(det => res.send(det))
})

svr.get('/employee/:id', checklogin, (req, res) => {
    let user=req.user.username
    connectdb('empmanag')
        .then(db => db.collection('empdetails').find({authId: req.params.id}))
        .then(det => det.toArray())
        .then(det => {
            res.render('employee', {det, user})
    })
})

svr.get('/getdept/:dept', checklogin, (req, res) => {
    let user=req.user.username
    let dept=req.user.dept
    connectdb('empmanag')
        .then(db => db.collection('users').find({dept: req.params.dept}))
        .then(det => det.toArray())
        .then(det => {
            
            res.render('all', {det, user, dept})
    })
})

svr.post('/updateemp/:id', checklogin, (req, res) => {
    let j=new ObjectID(req.params.id)
    connectdb('empmanag')
        .then(db => {
            let p=req.body.projects.split(',').length
            db.collection('users').updateOne({ _id: j }, { $set: { username: req.body.name, email: req.body.email, dept: req.body.dept, desig: req.body.desig } })
            db.collection('empdetails').updateOne({ authId: req.params.id }, { $set: { name: req.body.name,
                email: req.body.email,
                dob: req.body.dob,
                address: req.body.address,
                phone: req.body.phone,
                schoolname: req.body.schoolname,
                schoolmarks: req.body.schoolmarks,
                hname: req.body.hname,
                hcourse: req.body.hcourse,
                hmarks: req.body.hmarks,
                dept: req.body.dept,
                desig: req.body.desig,
                projects: req.body.projects,
                projno: p
             } })
        })
        .then(() => res.redirect('/employees'))
})

svr.delete('/delete/:id', checklogin, (req, res) => {
    connectdb('empmanag')
        .then(db => {
                let i=new ObjectID(req.params.id)
                db.collection('users').deleteOne({_id: i})
                db.collection('empdetails').deleteOne({authId: req.params.id})
        })
        .then(() => res.redirect('/employees'))
})

svr.get('/getresult/:key', checklogin, (req, res)  =>{
    
    const query = { username: { $regex: '.*' + req.params.key + '.*' } };

    connectdb('empmanag')
        .then( db=> db.collection('users').find(query))
        .then(data => data.toArray())
        .then(data=> {
            res.send(data)
        }).catch(err => {
            console.error(err);
            res.status(500).send(err);
          });
})

svr.listen(3000, () => {
    console.log('http://localhost:3000/')
})