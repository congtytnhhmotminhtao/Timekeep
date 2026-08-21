# Quy ước Commit Message (v3.1)

## 1. Cấu trúc chung

```
pattern[file]: mes

[body nếu cần, cách 1 dòng trống]
```

- `:` ngăn cách "địa chỉ" (pattern + file) và "nội dung" (mes).
- Nhiều file cùng pattern: mỗi file tự lặp lại ký hiệu, nối bằng dấu phẩy không cách, hoặc gom vào `{}`.
  ```
  +ltn,+paper,+quanlyfile: nap version dau tien
  +{ltn.lua,paper.lua,quanlyfile.lua}: nap version dau tien
  ```
  Tránh viết phẳng kiểu "lai" (chỉ ký hiệu trước file đầu, các file sau không rõ có kế thừa hay không) — dễ đọc nhầm khi rà lại.
- Branch phụ: `%{tên-nhánh}(file): mes` — vd `%hotfix(ltn.lua): sua loi crash`
- Merge nhánh phụ vào chính: `%{chính}(file)_%{phụ}(file): mes`

## 2. Version

Không có ký hiệu/vị trí riêng cho version trong pattern. Nếu cần ghi version, tự đưa vào **trong `mes`** như 1 phần nội dung bình thường, tự do miễn hiểu được đang đánh mốc gì.

```
+ltn,+paper: nap version dau tien, v0.0
@+ltn.lua,@+paper.lua: khoi tao du an ban dau (v0.1-alpha)
```

Không ràng buộc format cứng `v.x1.x2.x3`.

## 3. Bảng ký hiệu

| Ký hiệu | Ý nghĩa |
|---|---|
| `@` | Tạo file mới, rỗng |
| `@+` | Tạo file mới kèm nội dung |
| `**` | Hotfix |
| `*` | Fix bug |
| `+` | Thêm/xoá nội dung, file vẫn còn (mặc định) |
| `^` | Xoá vĩnh viễn cả file |
| `~` | Đổi tên hàm/biến, không đổi logic |
| `?` | Thử nghiệm, chưa chắc giữ |
| `#` | Test / benchmark |
| `=` | Đổi tên/di chuyển file |
| `//` | Tài liệu |
| `<` | Liên kết require |
| `&` | Revert |
| `%{tên}(file)` | Hành động trên nhánh phụ |
| `_` | Merge nhánh phụ vào chính |

## 4. Nguyên tắc tách commit

- Mỗi commit là 1 đơn vị có thể revert độc lập.
- Tránh gộp nhiều loại hành động không liên quan (vd `+` và `*`) trong cùng commit.
- Dùng `git add -p` để tách theo hunk khi cần.

## 5. Body

- Thêm khi fix bug logic phức tạp, hoặc cần giải thích *tại sao* (không chỉ *cái gì*) — pattern đã tự nói được "cái gì" thay đổi, `mes`/body dùng để bù phần pattern không diễn đạt được.
- Có thể breakdown từng file nếu commit gộp nhiều file:
  ```
  +ltn,+paper,+quanlyfile: nap version dau tien

  +ltn: khoi tao module serialization
  +paper: khoi tao module grid 2D
  +quanlyfile: khoi tao he thong quan ly file
  ```

## 6. Ghi chú

- Bảng mở — thêm ký hiệu mới phải: (1) không chồng nghĩa ký hiệu cũ, (2) ghi ngay vào file này.
- `*`/`**` an toàn trong quote đơn lẫn kép (khác `!` cũ — lỗi cả trong quote kép do Bash History Expansion).
- Lịch sử thay đổi:
  - v1: bản gốc, dùng `+`/`-`/`!`/`!?`/`v.x1.x2.x3`
  - v2: gộp `+`/`-`→`±`, nâng ưu tiên `!?`, tách `@`/`@+`, cú pháp branch `%{tên}(file)`, bỏ version cứng
  - v3: `±`→`+`, `!`→`X`/`!?`→`XX`, `$`→`_`
  - v3.1: `X`/`XX`→`*`/`**`; bỏ hẳn vị trí/ký hiệu riêng cho version — version tự do nằm trong `mes`
