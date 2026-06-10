import { fetchWithAuth } from './api.js';

async function fetchPosts() {
    return fetchWithAuth('/posts/', {
        method: 'GET',
    });
}

async function createPost(postData) {
    return fetchWithAuth('/posts/', {
        method: 'POST',
        body: JSON.stringify(postData),
    });
}

export { fetchPosts, createPost };