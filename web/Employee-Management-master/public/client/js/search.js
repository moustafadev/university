// Function to generate ticket elements
function generateTicketElements(ticketData) {
    const ticketResults = document.getElementById('ticket-results');
    
    // Clear previous ticket results
    ticketResults.innerHTML = '';
    
    // Generate ticket elements based on the data
    ticketData.forEach(ticket => {
      const ticketElement = document.createElement('div');
      ticketElement.classList.add('ticket');
      
      const airlineNameElement = createTicketElement('p', 'label', 'Airline:', ticket.airline_name);
      const fromElement = createTicketElement('p', 'label', 'From:', ticket.from);
      const toElement = createTicketElement('p', 'label', 'To:', ticket.to);
      const departureElement = createTicketElement('p', 'label', 'Departure:', ticket.departure);
      const arrivalElement = createTicketElement('p', 'label', 'Arrival:', ticket.arrival);
      const priceElement = createTicketElement('p', 'price', 'Price:', '$' + ticket.price);
      
      const buyButton = document.createElement('button');
      buyButton.classList.add('buy-button');
      buyButton.textContent = 'Buy Ticket';
      
      ticketElement.appendChild(airlineNameElement);
      ticketElement.appendChild(fromElement);
      ticketElement.appendChild(toElement);
      ticketElement.appendChild(departureElement);
      ticketElement.appendChild(arrivalElement);
      ticketElement.appendChild(priceElement);
      ticketElement.appendChild(buyButton);
      
      ticketResults.appendChild(ticketElement);
    });
  }
  
  // Function to create a ticket element
  function createTicketElement(tagName, className, label, value) {
    const element = document.createElement(tagName);
    element.classList.add(className);
    element.innerHTML = `<span class="label">${label}</span> ${value}`;
    return element;
  }
  
  // Fetch ticket data from Node.js server
  function fetchTicketData() {
    console.log("Cccccc");
    fetch('/tickets')
      .then(response => response.json())
      .then(ticketData => {
        console.log("Ccccccdscc");
        generateTicketElements(ticketData);
      })
      .catch(error => {
        console.error('Error:', error);
      });
  }
  
  // Generate ticket elements when the page loads
  fetchTicketData();