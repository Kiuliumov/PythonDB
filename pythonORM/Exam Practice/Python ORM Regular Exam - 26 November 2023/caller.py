import os
import django
from django.db.models import Avg, Max

from main_app.models import *
# Set up Django
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "orm_skeleton.settings")
django.setup()

# Import your models here

# Create queries within functions

def get_authors(search_name=None, search_email=None):
    authors = Author.objects.all()
    if search_name and search_email:
        authors = authors.filter(full_name__icontains=search_name, email__icontains=search_email)

    if search_name and not search_email:
        authors = authors.filter(full_name__icontains=search_name)
    if search_email and not search_name:
        authors = authors.filter(email__icontains=search_email)

    if not search_name and not search_email:
        return ''

    if not authors:
        return ''
    authors = authors.order_by('-full_name')

    authors_string = ''
    for author in authors:
        authors_string += f'Author: {author.full_name}, email: {author.email}, status: {"Banned" if author.is_banned else "Not Banned"}\n'
    return authors_string.rstrip()


def get_top_publisher():
    top_authors = Author.objects.annotate(articles_count=Count('articles')).order_by('-articles_count', 'email')
    if not top_authors:
        return ''
    top_author = top_authors[0]
    if top_author.articles_count == 0:
        return ''
    return f'Top Author: {top_author.full_name} with {top_author.articles_count} published articles.'

def get_top_reviewer():
    top_reviewers = Author.objects.annotate(reviews_count=Count('reviews')).order_by('-reviews_count', 'email')
    if not top_reviewers:
        return ''
    top_reviewer = top_reviewers[0]
    if top_reviewer.reviews_count == 0:
        return ''
    return f'Top Reviewer: {top_reviewer.full_name} with {top_reviewer.reviews_count} published reviews.'

def get_latest_article():
    articles = Article.objects.all()
    if not articles:
        return ''
    articles = articles.order_by('-published_on')
    latest_article = articles[0]
    def get_average_rating(article: Article):
        rating_count = 0
        rating_sum = 0
        if not article.reviews.exists():
            return 0
        for r in article.reviews.all():
            if r.rating:
                rating_count += 1
                rating_sum += r.rating
        return rating_sum / rating_count
    return f'The latest article is: {latest_article.title}. Authors: {", ".join(a.full_name for a in latest_article.authors.all())}. Reviewed: {latest_article.reviews.count()} times. Average Rating: {get_average_rating(latest_article):.2f}.'

from django.db.models import Avg

def get_top_rated_article():
    top_article = (
        Article.objects.annotate(avg_rating=Avg('reviews__rating'))
        .order_by('-avg_rating', 'title')
        .first()
    )

    if not top_article or top_article.avg_rating is None:
        return ''

    return f'The top-rated article is: {top_article.title}, with an average rating of {top_article.avg_rating:.2f}, reviewed {top_article.reviews.count()} times.'

def ban_author(email=None):
    author = Author.objects.filter(email=email).first()
    if not author:
        return f'No authors banned.'

    author.is_banned = True
    review_count = author.reviews.count()
    author.reviews.all().delete()
    author.save()
    return f'Author: {author.full_name} is banned! {review_count} reviews deleted.'