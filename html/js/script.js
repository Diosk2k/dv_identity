document.getElementById('identityForm').onsubmit = function(event) {
    event.preventDefault();
    const data = {
        firstname: document.getElementById('firstname').value,
        lastname: document.getElementById('lastname').value,
        dateofbirth: document.getElementById('dateofbirth').value,
        height: document.getElementById('height').value
    };

    fetch(`https://${GetParentResourceName()}/submitIdentity`, {
        method: 'POST',
        body: JSON.stringify(data),
        headers: {
            'Content-Type': 'application/json'
        }
    }).then(res => res.json()).then(() => {
        closeForm();
    });
};

function closeForm() {
    fetch(`https://${GetParentResourceName()}/close`, {
        method: 'POST',
    });
}
