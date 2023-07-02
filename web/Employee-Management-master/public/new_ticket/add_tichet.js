document.getElementById('ticket-form').addEventListener('submit', function (event) {
    event.preventDefault();
    const from = document.getElementById('from').value;
    const to = document.getElementById('to').value;
    const departure = document.getElementById('departure').value;
    const returnDate = document.getElementById('return').value;
    const price = document.getElementById('price').value;
    const ticket = {
        from,
        to,
        departure,
        returnDate,
        price
    };
    // Save the ticket to your database or API here
    console.log('Ticket to be added:', ticket);

    // Clear the form after submission
    event.target.reset();
});