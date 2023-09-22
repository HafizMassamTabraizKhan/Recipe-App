function initializeModal() {
    const modal = document.getElementById("myModal");
    const openModalButton = document.getElementById("myBtn");
    const closeModalButton = document.querySelector(".close");
  
    function openModal() {
      modal.style.display = "block";
    }
  
    function closeModal() {
      modal.style.display = "none";
    }
  
    openModalButton.addEventListener('click', openModal);
  
    closeModalButton.addEventListener('click', closeModal);
  
    document.addEventListener('click', function(event) {
      if (event.target === modal) {
        closeModal();
      }
    });
  }
  
initializeModal();
  