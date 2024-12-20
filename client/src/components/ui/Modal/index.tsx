import { FC, ReactNode } from "react";
import { Modal, Box } from "@mui/material";

type Props = {
  open: boolean;
  onClose: () => void;
  children: any;
};

const CustomModal: FC<Props> = ({ open, onClose, children }) => {
  return (
    <Modal
      open={open}
      onClose={onClose}
      aria-labelledby="modal-modal-title"
      aria-describedby="modal-modal-description"
    >
      <Box className="absolute top-[50%] left-[50%] -translate-x-1/2 -translate-y-1/2 w-[500px] m-auto  800px:w-[450px] bg-white dark:bg-slate-900 rounded-[8px] shadow p-4 outline-none">
        {children}
      </Box>
    </Modal>
  );
};

export default CustomModal;
