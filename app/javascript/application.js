// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('DOMContentLoaded', function() {
  // Event delegation for checkbox change event
  document.addEventListener('change', function(event) {
    if (event.target.matches('#public-checkbox')) {
      const form = document.getElementById('recipe-form');
      form.submit();
    }
  });

  // Event delegation for modal
  const modal = document.getElementById("myModal");
  const openModalButton = document.getElementById("myBtn");

  document.addEventListener('click', function(event) {
    if (event.target === openModalButton) {
      modal.style.display = "block";
    } else if (event.target.classList.contains("close") || event.target === modal) {
      modal.style.display = "none";
    }
  });
});

