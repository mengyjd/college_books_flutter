class HomeModel {
	List<String> bannerList;
	List<CategoryModel> categoryList;
	List<BookModel> bookList;

	HomeModel({this.bannerList, this.categoryList, this.bookList});

	HomeModel.fromJson(Map<String, dynamic> json) {
		bannerList = json['bannerList'].cast<String>();
		if (json['categoryList'] != null) {
			categoryList = [];
			json['categoryList'].forEach((v) {
				categoryList.add(new CategoryModel.fromJson(v));
			});
		}
		if (json['bookList'] != null) {
			bookList = [];
			json['bookList'].forEach((v) {
				bookList.add(new BookModel.fromJson(v));
			});
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['bannerList'] = this.bannerList;
		if (this.categoryList != null) {
			data['categoryList'] = this.categoryList.map((v) => v.toJson()).toList();
		}
		if (this.bookList != null) {
			data['bookList'] = this.bookList.map((v) => v.toJson()).toList();
		}
		return data;
	}
}

class CategoryModel {
	String id;
	String name;

	CategoryModel({this.id, this.name});

	CategoryModel.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		name = json['name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['name'] = this.name;
		return data;
	}
}

class BookModel {
	String bookId;
	String name;
	String cover;
	double price;
	String categoryId;

	BookModel({this.bookId, this.name, this.cover, this.price, this.categoryId});

	BookModel.fromJson(Map<String, dynamic> json) {
		bookId = json['bookId'];
		name = json['name'];
		cover = json['cover'];
		price = json['price'];
		categoryId = json['categoryId'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['bookId'] = this.bookId;
		data['name'] = this.name;
		data['cover'] = this.cover;
		data['price'] = this.price;
		data['categoryId'] = this.categoryId;
		return data;
	}
}
