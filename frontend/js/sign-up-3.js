document.addEventListener('DOMContentLoaded', () => {
    initUploadZone();
    initFormSubmission();
});

/**
 * Manages click bindings and UI states for the student ID file input.
 */
function initUploadZone() {
    const uploadZone = document.getElementById('upload-zone');
    const fileInput = document.getElementById('id-upload');
    const defaultState = document.getElementById('upload-default-state');
    const successState = document.getElementById('upload-success-state');
    const fileNameText = document.getElementById('file-name-text');

    if (!uploadZone || !fileInput) return;

    // Trigger standard system dialog when clicking the container
    uploadZone.addEventListener('click', () => {
        fileInput.click();
    });

    // Detect when a file has been selected
    fileInput.addEventListener('change', (e) => {
        if (e.target.files && e.target.files.length > 0) {
            const file = e.target.files[0];
            
            // UI Mutation: Change from standard to success state
            uploadZone.classList.remove('bg-surface-container-low', 'border-outline-variant');
            uploadZone.classList.add('bg-secondary-container', 'border-secondary');
            
            defaultState.classList.add('hidden');
            successState.classList.remove('hidden');
            
            fileNameText.textContent = `Photo Selected: ${file.name}`;
        }
    });
}

/**
 * Handles validation and simple client submission processing.
 */
function initFormSubmission() {
    const form = document.getElementById('final-registration-form');
    if (!form) return;

    form.addEventListener('submit', (e) => {
        e.preventDefault();
        
        const bioValue = document.getElementById('profile-bio').value;
        const idNumber = document.getElementById('student-id-number').value;
        const fileInput = document.getElementById('id-upload');
        const hasFile = fileInput.files && fileInput.files.length > 0;

        // Security check: at least one verification method must be provided
        if (!hasFile && !idNumber.trim()) {
            alert("S'il vous plaît, téléversez votre carte d'étudiant ou saisissez votre matricule.");
            return;
        }

        console.log("Submitting Registration Data...", {
            studentIdNumber: idNumber || null,
            bio: bioValue,
            documentProvided: hasFile ? fileInput.files[0].name : null
        });
        
        // Next Step Integration (e.g. AJAX call or redirection to dashboard)
    });
}