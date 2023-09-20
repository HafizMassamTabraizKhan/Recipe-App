// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('DOMContentLoaded', function() {
  const form = document.getElementById('recipe-form');
  const checkbox = document.getElementById('public-checkbox');

  if (form && checkbox) {
    checkbox.addEventListener('change', function() {
      form.submit();
    });
  }
});

