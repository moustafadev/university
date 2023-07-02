


$(document).ready(function() {
	$.getJSON("/client/js/ticket.json", function(data) {
		$.each(data, function(key, value) {
			var row = "<tr>";
			row += "<td>" + value.id + "</td>";
			row += "<td>" + value.airline_name + "</td>";
			row += "<td>" + value.from + "</td>";
			row += "<td>" + value.to + "</td>";
			row += "<td>" + value.departure + "</td>";
			row += "<td>" + value.arrival + "</td>";
			row += "<td>" + value.price + "</td>";
			row += "<td>" + value.total_seats + "</td>";
			row += "</tr>";
			$("#ticketTableBody").append(row);
		});
	});
});

document.getElementById('ticket-form').addEventListener('submit', function (event) {
  
  event.preventDefault();

  const from = document.getElementById('from').value;
  const airline = document.getElementById('airline').value;
  const to = document.getElementById('to').value;
  const departure = document.getElementById('departure').value;
  const returnDate = document.getElementById('return').value;
  const price = document.getElementById('price').value;
  const seats = document.getElementById('seats').value;

  const ticket = {
    airline_name: airline,
    from: from,
    to: to,
    departure: departure,
    arrival: returnDate,
    price: price,
    total_seats: seats
  };

  $.ajax({
    url: '/client/js/ticket.json',
    type: 'PUT',
    data: JSON.stringify(ticket),
    contentType: 'application/json',
    success: function(response) {
        console.log(response);
      },
    error: function(xhr, status, error) {
        console.error(error);
    }
  });

});






