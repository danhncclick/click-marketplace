# CLICK Video

© 2026 Nguyễn Bá Duy. Bảo lưu mọi quyền. Nghiêm cấm sao chép, phân phối, dịch ngược.

© 2026 Nguyễn Bá Duy. All rights reserved. Copying, redistribution and reverse engineering are prohibited.

Plugin dựng video TikTok cho trợ lý AI (Claude Code, Codex). Cần key bản quyền.

## Cài cho Claude Code

```
/plugin marketplace add danhncclick/click-marketplace
/plugin install click-video@click-media
```

Nhập key vào ô Claude Code hỏi khi cài.

## Cài cho Codex

```
codex plugin marketplace add danhncclick/click-marketplace
codex plugin add click-video@click-media
```

(Hoặc mở `codex`, gõ `/plugins`, chọn CLICK Video và cài.)

Codex hỏi cho phép mỗi lần plugin dùng một công cụ. Muốn khỏi hỏi, thêm vào `~/.codex/config.toml`:

```toml
[plugins."click-video@click-media".mcp_servers.click-video]
default_tools_approval_mode = "approve"
```

Key: lần đầu nhắn "dựng video", trợ lý sẽ hỏi key, bạn dán key vào khung chat. Key được lưu mã hoá trên máy, chỉ hỏi một lần. Hoặc đặt sẵn biến môi trường `CLICK_LICENSE_KEY` trước khi mở Codex. Lần đầu dùng, trợ lý cho bạn xem Thoả thuận cấp phép và chờ bạn đồng ý.

## Dung lượng

Bản cài cần khoảng 7–12 GB. Ổ C ít chỗ thì nói với trợ lý một thư mục trên ổ khác (ví dụ `E:\ClickVideo`): trợ lý chuyển phần nặng sang đó, trước hoặc sau khi cài.

Toàn bộ repo là tệp chữ, đọc được: bộ khởi động `plugins/click-video/bootstrap/` tải Python chính thức từ python.org và chỉ tải bộ máy khi key hợp lệ.

Thoả thuận cấp phép: [LICENSE.md](LICENSE.md). Thành phần bên thứ ba: [THANH-PHAN-BEN-THU-BA.md](THANH-PHAN-BEN-THU-BA.md).
