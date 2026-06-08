from apps.mentoring.repositories import MentorshipPostRepository


class MentorshipService:
    @staticmethod
    def create_post(creator, data):
        return MentorshipPostRepository.create(creator, data)

    @staticmethod
    def get_post(post_id):
        return MentorshipPostRepository.get_by_id(post_id)

    @staticmethod
    def list_posts(type=None, subject=None, format=None, department=None, status="OPEN"):
        return MentorshipPostRepository.get_all(type=type, subject=subject, format=format, department=department, status=status)

    @staticmethod
    def update_post(post_id, data):
        post = MentorshipPostRepository.get_by_id(post_id)
        if not post:
            return None
        return MentorshipPostRepository.update(post, data)

    @staticmethod
    def delete_post(post_id):
        post = MentorshipPostRepository.get_by_id(post_id)
        if not post:
            return False
        MentorshipPostRepository.delete(post)
        return True
