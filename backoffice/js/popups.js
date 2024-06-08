// Function to open a popup
function openPopup(popupId) {
    const popup = document.getElementById(popupId);
    popup.style.display = "block";
}

// Function to close a popup
function closePopup(popupId) {
    const popup = document.getElementById(popupId);
    popup.style.display = "none";
}

// Close popup when clicking outside of it
window.onclick = function(event) {
    const popups = document.querySelectorAll('.popup');
    for (let i = 0; i < popups.length; i++) {
        const popup = popups[i];
        if (event.target == popup) {
            popup.style.display = "none";
        }
    }
}
