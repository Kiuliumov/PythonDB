import os
import django

from main_app.models import Author, Book, Artist, Song, Product, Review

# Set up Django
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "orm_skeleton.settings")
django.setup()

# Import your models here

# Create queries within functions
def show_all_authors_with_their_books():
    authors = Author.objects.all()
    return_str = ''
    for author in authors:
        books = Book.objects.filter(author=author)
        if books:
            return_str += '{} has written - {}'.format(author.name, ", ".join([book.title for book in books])) + '!\n'
    return return_str.rstrip()

def delete_all_authors_without_books():
    authors = Author.objects.all()
    for author in authors:
        books = Book.objects.filter(author=author)
        if not books:
            author.delete()


def add_song_to_artist(artist_name: str, song_title: str):
    artist = Artist.objects.get(name=artist_name)
    song = Song.objects.get(title=song_title)

    artist.songs.add(song)


def get_songs_by_artist(artist_name: str):
    artist = Artist.objects.get(name=artist_name)
    return artist.songs.all().order_by('-id')

def remove_song_from_artist(artist_name: str, song_title: str):
    artist = Artist.objects.get(name=artist_name)
    song = Song.objects.get(title=song_title)
    artist.songs.remove(song)

def calculate_average_rating_for_product_by_name(product_name: str):
    product = Product.objects.get(name=product_name)
    reviews = product.reviews.all()
    average_rating = sum(r.rating for r in reviews) / reviews.count()
    return average_rating

def get_reviews_with_high_ratings(threshold: int):
    reviews = Review.objects.filter(rating__gte=threshold)
    return reviews

def get_products_with_no_reviews():
    return Product.objects.filter(reviews__isnull=True).order_by('-name')

def delete_products_without_reviews():
    get_products_with_no_reviews().delete()

