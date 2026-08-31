# TimeKeep

Ứng dụng chấm công cá nhân dạng CLI, viết bằng Lua thuần, chạy trên Termux (Android).
Personal time-tracking CLI app, written in pure Lua, running on Termux (Android).

Dev by **caothu9ok**

---

## Chạy chương trình / Run

​```bash
lua main.lua
​```

---

## Hướng dẫn sử dụng (Tiếng Việt)

### Màn hình chính

| Phím | Chức năng |
|---|---|
| `1` | Vào ca (timekeep in) |
| `2` | Ra ca (timekeep out) |
| `3` | Xem lịch sử chấm công |
| `4` | Cài đặt |
| `5` | Thoát |

### Màn hình lịch sử

| Lệnh | Chức năng |
|---|---|
| `j` | Trang trước |
| `k` | Trang sau |
| `/todate <mã phiên>` | Xem chi tiết 1 phiên theo mã |
| `/tong <lương/giờ>` | Tính tổng lương theo mức lương/giờ nhập vào |
| `q` | Quay lại menu |

### Cài đặt (Setting)

> **COMMING SOON!**
> Màn hình cài đặt hiện đang được phát triển, chưa có tùy chọn nào khả dụng. Các phiên bản sau sẽ bổ sung thêm tùy chỉnh (giờ ca chính thức, đơn vị tiền tệ...).

---

## Usage Guide (English)

### Main menu

| Key | Action |
|---|---|
| `1` | Check in |
| `2` | Check out |
| `3` | View history |
| `4` | Settings |
| `5` | Exit |

### History screen

| Command | Action |
|---|---|
| `j` | Previous page |
| `k` | Next page |
| `/todate <session id>` | View details of a specific session |
| `/tong <rate/hour>` | Calculate total salary at the given hourly rate |
| `q` | Back to menu |

### Settings

> **COMMING SOON!**
> The settings screen is still under development — no options are available yet. Future versions will add configurable options (official shift start time, currency unit, etc.).
