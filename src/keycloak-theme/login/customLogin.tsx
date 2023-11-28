import React from "react";

import MSS from "miracle-logo.svg";
import "./customlogin.css";
const CustomLogin = (props: any) => {
  return (
    <div className="bg-[#ffff] h-screen w-screen">
      <div className="flex">
        <div className="flex-[2]">
          <div
            className={`bg-cover bg-[#232332d4]  bg-blend-overlay   bg h-screen`}
          >
            <div className="h-screen    flex items-start p-20 flex-col justify-end">
              <div className="h-[15vh]">
                <div className=" text-miracle-blue text-5xl">
                  miraGPT KNOWLEDGE SPHERE
                </div>

                <p className="text-2xl !text-white">
                  {" "}
                  © {new Date().getFullYear()} Miracle Software Systems, Inc.{" "}
                </p>
              </div>
            </div>
          </div>
        </div>
        <div className="flex flex-1  justify-center overflow-hidden">
          <div className="flex items-center justify-center p-1 text-sm gap-3 flex-col w-[60%]">
            <img src={MSS} className="self-start !ml-[5%] h-20" alt="" />
            {props.children}
          </div>
        </div>
      </div>
    </div>
  );
};

export default CustomLogin;
