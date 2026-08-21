# TimeKeep

Ứng dụng chấm công cá nhân, chạy CLI thuần Lua trên Termux (Android), không có backend server, không multi-user.

## Môi trường phát triển

- Thiết bị: Samsung Galaxy A17 5G, chạy hoàn toàn qua Termux, không có PC
- Ngôn ngữ: Lua thuần (không dùng LuaRocks ngoài các thư viện tự viết)
- Editor: Neovim/NvChad
- Git: quản lý qua lazygit, theo quy ước riêng trong `COMMIT_CONVENTION.md`

## Kiến trúc

Theo mô hình `load` / `update` / `draw` giống LÖVE2D, áp dụng cho vòng lặp CLI:

- `load` — chạy 1 lần lúc khởi động, hiện màn hình chào (`ui.load("chao")`), chờ Enter, rồi vẽ menu chính
- `update` — đọc input qua `io.read()` (block chờ người dùng), xử lý theo `UItrangthai` hiện tại, đổi state
- `draw` — vẽ lại UI theo state mới nhất, dùng `paper.lua` để render ra terminal

Luồng gọi module: `main.lua → frontend/ui.lua → engine/paper.lua` và `main.lua → backend/chamcong.lua → engine/ltn_claude.lua + engine/quanlyfile.lua`

## Quy ước code

- Biến/hàm đặt tên tiếng Việt không dấu, kiểu camelCase (`vaoCa`, `danhSachPhien`, `taopaper`)
- Mỗi module tách rõ 2 khối `--private` và `--public`, comment đánh dấu rõ ràng
- Tên file khi Claude tạo mới: `<tên_module>_claude.lua` (ví dụ `ltn_claude.lua`)
- Lưu trữ dữ liệu dùng **1 file gộp duy nhất** (`chamcong.ltn`), ghi đè toàn bộ mỗi lần thay đổi — không tách file theo ngày, vì quy mô dữ liệu cá nhân nhỏ

## Trạng thái hiện tại

- `engine/paper.lua`, `engine/ltn_claude.lua`, `engine/quanlyfile.lua` — đã hoàn thiện, có test
- `frontend/ui.lua` — có màn hình `"menu"` và `"chao"`, các state chi tiết (`"1"`, `"history"`...) đang xây dần
- `backend/chamcong.lua` — bản RAM-only đã viết (`vaoCa`, `raCa`, `phienHienTai`, `tinhGio`), chưa nối lưu trữ
- `backend/luutru.lua` — đã phác thảo (nối `ltn_claude` + `quanlyfile`), chưa nối vào `chamcong.lua`
- `backend/thongke.lua` — chưa viết, dự kiến: tổng giờ theo ngày/tuần/tháng, streak
- `database/` — trống, sẽ chứa `chamcong.ltn`

## Việc tiếp theo (theo thứ tự ưu tiên)

1. Thêm `chamcong.napDuLieu(ds)` để nạp dữ liệu cũ từ `luutru.doc()` lúc khởi động
2. Nối `luutru.luu()` sau mỗi lần `vaoCa()`/`raCa()`
3. Hiện kết quả `vaoCa()`/`raCa()` ra `ui.lua` (case `UItrangthai == "1"`, `"2"`)
4. Viết `backend/thongke.lua` — tính tổng giờ, hiển thị bằng `paper.vehinhtron` làm progress ring
5. Màn hình lịch sử (`"history"`) — liệt kê các phiên đã lưu

## Quy tắc làm việc với AI

- Chỉ được **gợi ý code**, không tự ý tạo/sửa file trực tiếp trong dự án
- Mọi đoạn code đưa ra đều ở dạng preview trong hội thoại, chờ xác nhận rồi mới áp dụng vào file thật
- Không tự động chạy lệnh ghi đè file, commit, hay thao tác Git thay người dùng
