document.addEventListener("DOMContentLoaded", function() {
    loadFiles();
});

function uploadFile(event) {
    event.preventDefault();

    let fileInput = document.getElementById("fileInput");
    let files = fileInput.files;

    if (!files.length) {
        alert("Please select file(s) to upload.");
        return;
    }

    let progressBar = document.getElementById("progressBar");
    let progressContainer = document.getElementById("progressContainer");
    let formData = new FormData();

    for (let i = 0; i < files.length; i++) {
        formData.append("files", files[i]);  // Use the same key "files"
    }

    let xhr = new XMLHttpRequest();
    xhr.open("POST", "/upload", true);

    xhr.upload.onprogress = function (e) {
        if (e.lengthComputable) {
            let percentComplete = (e.loaded / e.total) * 100;
            progressBar.style.width = percentComplete + "%";
            progressBar.innerText = Math.round(percentComplete) + "%";
        }
    };

    xhr.onload = function () {
        if (xhr.status == 200) {
            alert("File(s) uploaded successfully!");
            window.location.reload();
        } else {
            alert("Error uploading file(s).");
        }
    };

    progressContainer.style.display = "block";
    xhr.send(formData);
}


function loadFiles() {
    let fileList = document.getElementById("fileList");
    fileList.innerHTML = "";

    fetch("/list-files")
        .then(response => response.json())
        .then(data => {
            data.forEach(file => {
                let li = document.createElement("li");
                let link = document.createElement("a");
                link.href = "/uploads/" + file;
                link.target = "_blank";
                link.textContent = file;

                let fileType = file.split(".").pop().toLowerCase();
                if (["png", "jpg", "jpeg", "gif"].includes(fileType)) {
                    let img = document.createElement("img");
                    img.src = "/uploads/" + file;
                    img.style.width = "100px";
                    img.style.borderRadius = "5px";
                    li.appendChild(img);
                }

                li.appendChild(link);
                fileList.appendChild(li);
            });
        })
        .catch(error => console.error("Error loading files:", error));
}


function displayFileSize() {
    let fileInput = document.getElementById("fileInput");
    let fileSizeDisplay = document.getElementById("fileSize");

    if (fileInput.files.length > 0) {
        let totalSize = 0;
        for (let i = 0; i < fileInput.files.length; i++) {
            totalSize += fileInput.files[i].size;
        }
        fileSizeDisplay.innerText = `Total Size: ${(totalSize / 1024).toFixed(2)} KB`;
    } else {
        fileSizeDisplay.innerText = "";
    }
}
